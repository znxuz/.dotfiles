import rosepine

# load your autoconfig, use this, if the rest of your config is empty!
config.load_autoconfig()

# set the palette you'd like to use
# valid options are 'rose-pine', 'rose-pine-moon' and 'rose-pine-dawn'
# last argument (optional, default is False): enable the plain look for the menu rows
rosepine.setup(c, 'rose-pine-dawn', True)

c.content.blocking.adblock.lists = ['https://easylist.to/easylist/easylist.txt',
 'https://easylist.to/easylist/easyprivacy.txt',
 'https://easylist-downloads.adblockplus.org/easylistdutch.txt',
 'https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt',
 'https://www.i-dont-care-about-cookies.eu/abp/',
 'https://secure.fanboy.co.nz/fanboy-cookiemonster.txt']
