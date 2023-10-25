import os.path
import sys
import unittest

# access the main library
sys.path.append(os.path.abspath(os.path.join(__file__,
                                "../../../../main/python")))

# access the test library
sys.path.append(os.path.abspath(os.path.join(__file__,
                                "../../../../test/python")))

from stumc_core_library.user_prefs.dao import get_prefs

class TestCoreLibrary(unittest.TestCase):

    def _init__(self):
        pass

    def setUp(self) -> None:
        pass

    def tearDown(self) -> None:
        pass

    def test_simple_get_user_prefs(self):
        self.assertIsNotNone(get_prefs("my_user"))