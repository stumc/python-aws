"""Get User Preference lambda"""
from stumc_core_library.user_prefs.dao import get_prefs

def lambda_function(event, context):
    """Entry point for lamnda"""
    return get_prefs(event)