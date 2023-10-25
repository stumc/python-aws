def make_default_prefs(user_id):
    return {
        "prefs":
            {
                "greeting": f"hello world {user_id}",
                "user_id": user_id
             }
    }


store = {}


def get_prefs(user_id):
    default_store = make_default_prefs(user_id)
    return store.get(user_id, default_store) if store else default_store


def set_prefs(user_id, data):
    global store
    store[user_id] = data
    return store
