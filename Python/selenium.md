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

    + find_element_by_name() vs find_elements_by_name()
    
    find_elements_by_name(): return list
    
    + find_elements()
    
    ```python
    from selenium.webdriver.common.by import By
    webdriver.find_elements(By.NAME, <string>)[0].send_keys(<string>)
    webdriver.find_elements(By.XPATH, "//input[@value='<string>']")[0].click()
    ```
    
* Keys class provide keys in the keyboard like RETURN, F1, ALT etc.

* support browser

Currently supported WebDriver implementations are Firefox, Chrome, Ie and Remote

* common functions

1.获取当前页面的Url函数

方法：current_url

2.获取元素坐标

方法：location

解释：首先查找到你要获取元素的，然后调用location方法

实例：

driver.find_element_by_xpath("//*[@id='tablechart']/tbody/tr[14]/td[9]").location

3.表单的提交

方法：submit

解释:查找到表单（from）直接调用submit即可

实例：

driver.find_element_by_id("form1").submit()

4.获取CSS的属性值

方法：value_of_css_property(css_name)
实例：
driver.find_element_by_css_selector("input.btn").value_of_css_property("input.btn")
5.获取元素的属性值
方法：get_attribute(element_name)
实例：
driver.find_element_by_id("sellaiyuan").get_attribute("sellaiyuan")
6.判断元素是否被选中
方法：is_selected()
实例：
driver.find_element_by_id("form1").is_selected()
7.返回元素的大小
方法：size
实例：
driver.find_element_by_id("iptPassword").size
返回值：{'width': 250, 'height': 30}
8.判断元素是否显示
方法：is_displayed()
实例：
driver.find_element_by_id("iptPassword").is_displayed()
9.判断元素是否被使用
方法：is_enabled()
实例：
driver.find_element_by_id("iptPassword").is_enabled()
10.获取元素的文本值
方法：text
实例：driver.find_element_by_id("iptUsername").text
11.元素赋值
方法：send_keys(*values)
实例：
driver.find_element_by_id("iptUsername").send_keys('admin')
注意如果是函数需要增加转义符u,eg.
driver.find_element_by_id("iptUsername").send_keys(u'青春')
12.返回元素的tagName
方法：tag_name
实例：
driver.find_element_by_id("iptUsername").tag_name
13.删除浏览器所以的cookies
方法：delete_all_cookies()
实例：
driver.delete_all_cookies()
14.删除指定的cookie
方法：delete_cookie(name)
实例：deriver.delete_cookie("my_cookie_name")
15.关闭浏览器
方法：close()
实例：driver.close()
16.关闭浏览器并且推出驱动程序
方法：quit()
实例：driver.quit()
17.返回上一页
方法：back()
实例：driver.back()
18.设置等待超时
方法：implicitly_wait(wait_time)
实例：driver.implicitly_wait(30)
19.浏览器窗口最大化
方法：maximize_window()
实例：driver.maximize_window()
20.查看浏览器的名字
方法：name
实例：drvier.name



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