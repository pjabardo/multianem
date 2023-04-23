import numpy as np


class Thermistor(object):
    """
    Creates an object that models an NTC thermistor.

    Parameters:

     * `R0` The resistance at reference temperature `T0`
     * `B` B-parameter in Kelvin
     * `T0` Reference temperature in oC
    """
    def __init__(self, R0=5e3, B=3950, T0=25):
        self.R0 = R0
        self.B = B
        self.T0 = T0 + 273.15

    def resistance(self, T=None):
        """
        Calculates the resistance of a thermistor at a given temperature.

        If no temperature is provided as an argument, the resistance at
        the reference temperature is returned.

        The single parameter `T` is the temperature in oC (if not `None`).
        """
        if T is None:
            return self.R0
        return self.R0 * np.exp( -self.B * (1/self.T0 - 1/(T+273.15) ))

    def temperature(self, R=None):
        """
        Returns the temperature required for the thermistor to reach a
        resistance of `R` Ohms.

        If no resistane value is provided or if it is `None`, the
        reference temperature is returned.
        """
        if R is None:
            return self.T0 - 273.15
        return -273.15 + 1/(1/self.T0 + 1/self.B * np.log(R/self.R0))
    
    def __call__(self, T=25.0):
        return self.resistance(T)

class Resistor(object):
    """
    Creates an object that models a resistor whose resistance varies
    linearly with temperature

    Parameters:

     * `R0` Resistance at reference temperature `R0`
     * `a` Temperature coefficient
     * `T0` Reference temperature.
     
    """
    def __init__(self, R0, a=0.4e-2, T0=25):
        self.R0 = R0
        self.a = a
        self.T0 = T0
    def resistance(self, T=None):
        """
        Calculates the resistance of a resistor at a given temperature.

        If no temperature is provided as an argument, the resistance at
        the reference temperature is returned.

        The single parameter `T` is the temperature in oC (if not `None`).
        """
        if T is None:
            return self.R0
        return self.R0 * (1 + a * (T-self.T0))
    def __call__(self, T=None):
        return self.resistance(T)
    def temperature(self, R=None):
        """
        Returns the temperature required for the resistor to reach a
        resistance of `R` Ohms.

        If no resistane value is provided or if it is `None`, the
        reference temperature is returned.
        """
        if R is None:
            return self.T0
        return self.T0 + 1/self.a * (R/self.R0 - 1)
    

class CTASensor(object):
    """
    Creates an object that models a CTA (constant temperature anemometer).

    Parameters:

     * `R` An object that represents a temperature varying resistor
     * `Rw` Operating resistance of the CTA
     * `T0` Reference temperature of the CTA

     The `R` parameter is ususally an object of type `Thermistor` or
     `Resistor`.
    """

    def __init__(self, R, Rw,T0=None):
        if T0 is None:
            self.T0 = R.T0 - 273.15
        else:
            self.T0 = T0
                
        self.R = R
        self.Rw = Rw
        self.n = 0.4
        self.cal = None
        self.Pa = 93.0
        
        
    def temperature(self):
        """
        Returns the operating temperature of the CTA
        """
        return self.R.temperature(self.Rw)
    
    def overheat_ratio(self):
        """
        Returns the overheat ratio of the anmemometer.

        For NTC thermistors this number is negative.
        """
        return self.Rw / (self.R.resistance(self.T0)) - 1.0

    def overtemp(self):
        """
        Returns the temperature above reference temperature that
        the CTA is operating.
        """
        return self.temperature() - self.T0

    def tempcorr(self, E, temp, Pa):
        """
        Corrects anemometer output for temperature variations.

        In the future it will also correct for variations in pressure
        and fluid composition.

        Parameters:

         * `E` Output voltage of the anemometer
         * `temp` Temperature of the anemometer
         * `Pa` Ambient pressure of the anemometer

         This method then returns the corrected voltage output
        """
        Tw = self.temperature()
        return E * np.sqrt( (Tw - self.T0) / (Tw - temp) )


    def calibr(self, E, U, T, Pa=93.0, n=0.4, K=5):
        """
        Adds a calibration to the anemometer

        The calibration consists of velocity and voltage output at
        a specific pressure and temperature. The voltage is corrected
        to the reference temperature of the anemometer and the data is
        fitted to the points using the following relationship:

        `Uⁿ = a₀ + a₁E² + a₂(E²)² + ⋯ + aₖ(E²)ᵏ`

        Parameters:

         * `E` List of calibration output voltage
         * `U` List of calibration velocities
         * `T` List or single value of calibration temperature
         * `Pa` List or single value of calibration pressure
         * `n` Power of velocity used in calibration curve
         * `K` Degree of polynomial that will be fitted
         
        """
        
        Ec = self.tempcorr(E, T, Pa)
        
        E2 = Ec * Ec
        Un = U ** n

        self.E = Ec
        self.U = U
        self.n = n
        self.Pa = Pa
        self.cal = np.polyfit(E2, Un, K)

        return None

    def velocity(self, E, T=None, Pa=None):
        """
        Uses the calibration curve to compute the velocity.

        The function corrects for changes in ambient conditions
        """
        if self.cal is None:
            raise RuntimeError("No calibration present!")
        
        if Pa is None:
            Pa = self.Pa
        if T is None:
            T = self.T0
        
        Ec = self.tempcorr(E, T, Pa)
        E2 = Ec*Ec
        return np.polyval(self.cal, E2) ** (1/self.n)
    
    def __call__(self, E, T=None, Pa=None):
        return self.velocity(E, T, Pa)
    
        
        
        
