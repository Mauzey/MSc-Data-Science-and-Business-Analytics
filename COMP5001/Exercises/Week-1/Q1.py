# import
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import math

sns.set_style('whitegrid')

def compute_snells_law(incidence_angle, verbose=False):
    """ Compute Snell's law, given the angle of incidence ('incidence_angle') in degrees

        Returns the angle of refraction in degrees
    """

    # constants
    rid_air = 1 # refractive index of the air
    rid_glass = 1.4 # refractive index of the glass

    # ensure that the angle of incidence is between -90 and 90 degrees
    if not (incidence_angle >= -90) & (incidence_angle <= 90):
        return print('[ERROR] Angle of Incidence should be between -90 and 90. ({} given)'.format(incidence_angle))

    # convert the angle of incidence from degrees to radians
    incidence_angle_rad = incidence_angle * (math.pi/180)

    # compute the angle of refraction
    refraction_angle = math.asin((rid_air / rid_glass) * math.sin(incidence_angle_rad))

    # convert the angle of refraction from radians to degrees
    refraction_angle_deg = refraction_angle * (180/math.pi)

    # print and return
    if verbose:
        print('[INFO] Angle of Refraction (when Angle of Incidence == {}) = {}'.format(incidence_angle, refraction_angle_deg))

    return refraction_angle_deg
###

# list of [incidence_angle, refraction_angle] data
data = []
for angle in range(-90, 91):
    data.append([angle, compute_snells_law(angle)])

# insert that data into a dataframe
df = pd.DataFrame(data, columns=['Incidence_Angle', 'Refraction_Angle'])

# plot the data
sns.lineplot(data=df, x='Incidence_Angle', y='Refraction_Angle', color='#bc5090')

# configure the plot and show it
plt.xlabel('Incidence Angle (degrees)')
plt.ylabel('Refraction Angle (degrees)')
plt.title('Incidence Angle vs. Refraction Angle (Air to Glass)')
plt.show()