# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class OlympicMedalsProjectItem(scrapy.Item):

    Year = scrapy.Field()
    Host_city = scrapy.Field()
    Host_country = scrapy.Field()
    Country_Name =  scrapy.Field()
    Country_Code = scrapy.Field()
    Gold = scrapy.Field()
    Silver = scrapy.Field()
    Bronze = scrapy.Field()
