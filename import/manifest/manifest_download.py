
'''
Name: Dean Magee
Date: 6th June 2016
Purpose: To import the 'Hazardous Waste Manifest Data' from http://www.dec.ny.gov/chemical/9098.html
            Also contains the tests to check the downloaded files
'''
from bs4 import BeautifulSoup
from urllib.request import urlopen,urlretrieve
import os
import sys

download_dir = sys.argv[1]
response = urlopen('http://www.dec.ny.gov/chemical/9098.html')

doc = response.read()
soup = BeautifulSoup(doc)

# Download the required files and save them in manifest_data directory
for link in soup.find_all('a'):
    if link.get('href') != '#pagecontent': #deals with strange link on page
        if link.get('href') is not None and link.get('href')[-1] == 't' :
            print('Getting....' + link.get('href'))
            urlretrieve(link.get('href'), download_dir + link.get('href').rsplit('/', 1)[-1])
        elif link.get('href') is not None and link.get('href')[-1] == 'v':
            print('Getting....' + link.get('href'))
            urlretrieve(link.get('href'),download_dir + link.get('href').rsplit('/', 1)[-1])


#Run tests on the files to ensure that they exist and contain Data

for link in soup.find_all('a'):
    if link.get('href') != '#pagecontent': #deals with strange link on page
        if link.get('href') is not None and link.get('href')[-1] == 't' :
            file_path = download_dir+ link.get('href').rsplit('/', 1)[-1]
            assert os.path.exists(file_path) and (os.path.getsize(file_path) > 0)
        elif link.get('href') is not None and link.get('href')[-1] == 'v':
            file_path = download_dir + link.get('href').rsplit('/', 1)[-1]
            assert os.path.exists(file_path) and (os.path.getsize(file_path) > 0)
