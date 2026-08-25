import unittest

from near_core import NearbyUser, rank_nearby, safe_recent_label


class NearCoreTests(unittest.TestCase):
    def test_closest_first(self):
        users = [
            NearbyUser("far", "Far", 20, (), 500, "LIVE"),
            NearbyUser("near", "Near", 20, (), 25, "RECENT"),
        ]
        ranked = rank_nearby(users)
        self.assertEqual(ranked[0].user_id, "near")

    def test_recent_label_never_contains_coordinates(self):
        label = safe_recent_label(5)
        self.assertEqual(label, "5分前にこの周辺")
        self.assertNotIn("lat", label.lower())
        self.assertNotIn("lon", label.lower())

    def test_public_user_model_has_no_raw_coordinates(self):
        user = NearbyUser("u1", "Aki", 24, ("Cafe",), 42, "LIVE")
        public = user.public()
        self.assertNotIn("latitude", public)
        self.assertNotIn("longitude", public)
        self.assertNotIn("lat", public)
        self.assertNotIn("lon", public)


if __name__ == "__main__":
    unittest.main()
