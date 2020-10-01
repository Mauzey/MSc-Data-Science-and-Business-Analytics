# import
from datetime import datetime


def main():
    # times and dates can be formatted using a set of predefined string control
    #   codes
    now = datetime.now()
    
    # DATE FORMATTING
    # %y/%Y - year, %a/%A - weekday, %b/%B - month, %d - day of month
    print(now.strftime("%a, %d %B, %y"))
    
    # %c - locale's date and time, %x - locale's date, %X - locale's time
    print(now.strftime("Locale date and time: %c"))
    print(now.strftime("Locale date: %x"))
    print(now.strftime("Locale time: %X"))
    
    # TIME FORMATTING
    # %I/%H - 12/24 hour, %M - minute, %S - second, %p - locale's AM/PM
    print(now.strftime("Current time: %I:%M:%S %p"))
    print(now.strftime("Current 24hr time: %H:%M"))


if __name__ == '__main__':
    main()
