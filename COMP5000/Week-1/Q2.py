# Q2: Python Logic and Functions
#   Write a function which takes as input a velocity (in MPH) of a vehicle driving on a UK motorway,
#   which prints out a warning if the velocity is greater than 70. Can you think of ways to make
#   the function more useful?

speed_limit = {
    'built-up-area': {
        'car-motorcycle': 30, 'towing': 30, 'bus-coach': 30, 'goods-vehicles': 30
    },
    'single-carriageway': {
        'car-motorcycle': 60, 'towing': 50, 'bus-coach': 50, 'goods-vehicles': 50
    },
    'dual-carriageway': {
        'car-motorcycle': 70, 'towing': 60, 'bus-coach': 60, 'goods-vehicles': 60
    },
    'motorway': {
        'car-motorcycle': 70, 'towing': 60, 'bus-coach': 70, 'goods-vehicles': 60
    }
}

# user selects vehicle type
print('Please select a vehicle type: \n(1: Car/Motorcycle)\n(2: Car Towing)\n(3: Bus/Coach)\n(4: Goods Vehicle)')
user_input = input('\nVehicle Type: ')

# parse user input
vehicles = {
    '1': 'car-motorcycle',
    '2': 'towing',
    '3': 'bus-coach',
    '4': 'goods-vehicles'
}
vehicle_type = vehicles.get(user_input, -1)

# user selects road type
print('Please select a road type: \n(1: Built-Up Area)\n(2: Single Carriageway)\n(3: Dual Carriageway)\n(4: Motorway)')
user_input = input('\nRoad Type: ')

# parse user input
roads = {
    '1': 'built-up-area',
    '2': 'single-carriageway',
    '3': 'dual-carriageway',
    '4': 'motorway'
}
road_type = roads.get(user_input, -1)

# user enters a speed
speed = int(input('\nHow fast is the vehicle travelling (MPH): '))

if speed > speed_limit[road_type][vehicle_type]:
    print('Vehicle\'s speed ({}mph) is above the limit ({}mph)'.format(speed, speed_limit[road_type][vehicle_type]))
else:
    print('Vehicle\'s speed ({}mph) is within the limit ({}mph)'.format(speed, speed_limit[road_type][vehicle_type]))