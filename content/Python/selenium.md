---
title: "Selenium and Xvfb "
date: 2016-01-22 14:41
---

## reference

* [selenium-python doc][1]

[1]: http://selenium-python.readthedocs.org/getting-started.html

## install

```
pip install selenium
```

## simple example

```python
import unittest
from selenium import webdriver
from selenium.webdriver.common.keys import Keys

class PythonOrgSearch(unittest.TestCase):

    def setUp(self):
        self.driver = webdriver.Firefox()

    def test_search_in_python_org(self):
        driver = self.driver
        driver.get("http://www.python.org")     #visit url
        self.assertIn("Python", driver.title)   # confirm
        elem = driver.find_element_by_name("q")
        elem.send_keys("pycon")         #input
        elem.send_keys(Keys.RETURN)
        assert "No results found." not in driver.page_source

    def tearDown(self):
        self.driver.close()     #close browser

if __name__ == "__main__":
    unittest.main()
```

* close vs quit

    + close() 
    
    close browser
    
    + quit()
    
    close a tab

* input like human

    + send_keys(string)
    
    + click()
    
    + clear()

* find element

    + find_element_by_name()
    
    + find_elements()
    
    ```python
    from selenium.webdriver.common.by import By
    webdriver.find_elements(By.NAME, <string>)[0].send_keys(<string>)
    webdriver.find_elements(By.XPATH, "//input[@value='<string>']")[0].click()
    ```
    
* Keys class provide keys in the keyboard like RETURN, F1, ALT etc.

* support browser

Currently supported WebDriver implementations are Firefox, Chrome, Ie and Remote



# Xvfb
 
It is an X11 server that performs all graphical operations in memory, not showing any screen output

Only a network layer is necessary.
 
## install

```
System Requirements:

sudo apt-get install xvfb   # or similar)
pip install xvfbwrapper
```
## example

```python
import unittest

from selenium import webdriver
from xvfbwrapper import Xvfb


class TestPages(unittest.TestCase):

    def setUp(self):
        self.xvfb = Xvfb(width=1280, height=720)
        self.addCleanup(self.xvfb.stop)
        self.xvfb.start()
        self.browser = webdriver.Firefox()
        self.addCleanup(self.browser.quit)

    def testUbuntuHomepage(self):
        self.browser.get('http://www.ubuntu.com')
        self.assertIn('Ubuntu', self.browser.title)

if __name__ == '__main__':
    unittest.main(verbosity=2)
```