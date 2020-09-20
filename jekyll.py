import tweepy
import matplotlib.pyplot as plt
import time

# Autenticación
exec(open('acceso.py').read())

usuario = api.get_user('PabloIglesias')

l_followers = tweepy.Cursor(api.followers, screen_name='l_hansa').items(5)

n_followers = [c.followers_count for c in l_followers]
n_followers = []
for c in l_followers:
    n_followers.append(c.followers_count)
    time.sleep(3)

print(n_followers)