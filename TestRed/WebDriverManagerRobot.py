from webdrivermanager import ChromeDriverManager
from webdrivermanager import GeckoDriverManager
# import platform

class WebDriverManagerRobot(object):

    ROBOT_LIBRARY_VERSION = 1.0



    def download_newest_webdriver(self, dir_path, browser):
        browser_l = str(browser).lower()
        if browser_l == "firefox":
            #downlaod firefox
            GeckoDriverManager(download_root=dir_path, link_path=dir_path, bitness="64").download_and_install()
            print("Firefox driver downloaded " + dir_path)
        elif browser_l == "chrome":
            #download chrome
            ChromeDriverManager(download_root=dir_path, link_path=dir_path, bitness="64").download_and_install()
            print("Chrome driver downloaded " + dir_path)
        else:
            print("atm there is only support for firefox, chrome")
    def three_variables(one, two, three):
        print(one + two + three)