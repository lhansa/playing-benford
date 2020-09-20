#%% Librerías
import tweepy           
import matplotlib.pyplot as plt
import time
import pprint

#%% Autenticación
exec(open('acceso.py').read())

# usuario = api.get_user('PabloIglesias')

#%% Descarga followers
l_followers = tweepy.Cursor(api.followers, screen_name='l_hansa').items()

#%% Explora followers
count = 0
for follower in l_followers:   
    count+=1

print(count)


n_followers = [c.followers_count for c in l_followers]
n_followers = []
for c in l_followers:
    n_followers.append(c.followers_count)
    time.sleep(3)

print(n_followers)