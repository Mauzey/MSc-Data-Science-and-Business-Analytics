# import
from datetime import datetime
from datetime import date
from datetime import time


def main():
    # DATE OBJECTS
    # get today's date from the simple today() method from the date class
    today = date.today()
    print("Today's date is: ", today)
    
    # print out the date's individual components
    print("Date components: ", today.day, today.month, today.year)
    
    # retrieve today's weekday number (0: monday, 6: sunday)
    print("Today's weekday # is: ", today.weekday())
    
    # DATETIME OBJECTS
    # get today's date from the datetime class
    today = datetime.now()
    print("The current date and time is: ", today)
    
    # get the current time
    t = datetime.time(datetime.now())
    print("The current time is: ", t)
    

if __name__ == '__main__':
    main()
