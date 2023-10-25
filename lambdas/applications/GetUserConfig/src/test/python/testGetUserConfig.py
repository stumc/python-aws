import os.path
import sys
import unittest

# access the main function
sys.path.append(os.path.abspath(os.path.join(__file__,
                                "../../../main/python")))

# access the main library
sys.path.append(os.path.abspath(os.path.join(__file__,
                                "../../../../../../layers/stumc_core_library_module/src/main/python")))

# access the test library
sys.path.append(os.path.abspath(os.path.join(__file__,
                                "../../../../../../layers/stumc_core_library_module/src/test/python")))


class TestGetUserConfig(unittest.TestCase):

    def _init__(self, *argv, **kwargs):
        super(TestGetUserConfig, self).__init__(*argv, **kwargs)
        self.lambda_target_module = None

    def setUp(self) -> None:
        self.lambda_target_module = __import__("lambda_entry")

    def tearDown(self) -> None:
        return

    def test_simple_get_user_prefs(self):
        result = self.lambda_target_module.lambda_function({"user": "user1"}, {"context": True})
        self.assertTrue(result)
