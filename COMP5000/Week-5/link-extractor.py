# Link Extractor
# extracts all links from a defined webpage

# import and setup
from bs4 import BeautifulSoup
import requests

url_ = 'https://github.com/'
req_ = requests.get(url_)
soup = BeautifulSoup(req_.content, 'html.parser')

links = []
for link in soup.find_all('a'):
    links.append(link.get('href'))

print(links)
