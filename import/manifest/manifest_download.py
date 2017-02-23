'''
Name: Dean Magee
Date: 6th June 2016
Purpose: To import the 'Hazardous Waste Manifest Data' from http://www.dec.ny.gov/chemical/9098.html
            Also contains the tests to check the downloaded files
'''
from bs4 import BeautifulSoup
import urllib
import os
import sys

download_dir = sys.argv[1]
response = urllib.urlopen('http://www.dec.ny.gov/chemical/9098.html')

doc = response.read()
soup = BeautifulSoup(doc, "html.parser")

# Download the required files and save them in manifest_data directory
for link in soup.find_all('a'):
    if link.get('href') != '#pagecontent': #deals with strange link on page
        if link.get('href') is not None and link.get('href')[-4:len(link.get('href'))] in ('.txt','.csv'):
            print('Getting....' + link.get('href'))
            file_path = os.path.join(download_dir , link.get('href').rsplit('/', 1)[-1])
            print('Saving as ....' + file_path)
            urllib.urlretrieve(link.get('href'), file_path)
            # Run a test to check that the file was downloaded correctly
            assert os.path.exists(file_path) and (os.path.getsize(file_path) > 0)
