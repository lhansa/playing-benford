import tweepy
import matplotlib.pyplot as plt
import time

# Autenticación
exec(open('acceso.py').read())

usuario = api.get_user('PabloIglesias')

l_followers = tweepy.Cursor(api.followers, screen_name='l_hansa')
         
l_followers