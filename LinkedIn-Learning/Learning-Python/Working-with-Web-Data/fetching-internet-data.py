# import
import urllib.request


def main():
    # open the url and store to 'web_url'
    web_url = urllib.request.urlopen("http://www.google.com")
    print("Result code: " + str(web_url.getcode()))
    
    # read contents of the url into 'data'
    data = web_url.read()
    # print(data)


if __name__ == '__main__':
    main()
