def make_default_prefs(user_id):
    return {
        "prefs":
            {
                "greeting": f"hello world {user_id}",
                "user_id": user_id
             }
    }


store = None


def get_prefs(user_id):
    return store if store else make_default_prefs(user_id)

def set_prefs(user_id, data):
    store = data
    return store
