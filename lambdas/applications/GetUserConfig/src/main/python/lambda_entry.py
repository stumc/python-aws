from stumc_core_library.user_prefs.dao import get_prefs

def lambda_function(event, context):
    return get_prefs(event)