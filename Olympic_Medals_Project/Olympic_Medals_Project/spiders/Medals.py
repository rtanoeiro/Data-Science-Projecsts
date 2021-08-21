import scrapy
from ..items import OlympicMedalsProjectItem

pages_to_scrap = list()
olympic_years = ["1896","1900","1904","1908","1912","1920","1924","1928","1932","1936","1948","1952","1956","1960","1964","1968","1972","1976","1980",
                "1984","1988","1992","1996","2000","2004","2008","2012","2016","2020"] #Years of olympic editions


for i in olympic_years:
    pages_to_scrap.append("https://en.wikipedia.org/wiki/{}_Summer_Olympics_medal_table".format(i))

class MedalsSpider(scrapy.Spider):
    name = 'Medals'
    start_urls = ['https://en.wikipedia.org']

    def parse(self, response):
        
        for i in pages_to_scrap:
            url = i
            print("\n")
            print("Selected page: ", i)
            print("\n")
            yield response.follow(url=url, callback=self.get_medals) ##Redirect scrapy to the next page

    def get_medals(self, response):
        
        Data = OlympicMedalsProjectItem()
        
        Data["Year"] = response.xpath("//*[@id='firstHeading']/text()").get()[0:4] ## Extract only the first 4 digits of the title, which is the year
        year = Data["Year"]

        Data["Host_city"] = response.xpath("//*[@id='mw-content-text']/div[1]/table[1]/tbody/tr[2]/td/a[1]/text()").get()
        Data["Host_country"] = response.xpath("//*[@id='mw-content-text']/div[1]/table[1]/tbody/tr[2]/td/a[2]/text()").get()

        if year == "1900": ## 1900 has a different table structure
            TableBox = response.xpath("//*[@id='mw-content-text']/div[1]/table[2]/tbody/tr")
            size_TableBox =  len(TableBox)
            TableBox = TableBox[1:(size_TableBox-1)] ## The first and last lines are always null, so we remove them.
        else:
            TableBox = response.xpath("//div/table[@class='wikitable sortable plainrowheaders jquery-tablesorter'][1]/tbody/tr")
            size_TableBox =  len(TableBox)
            TableBox = TableBox[1:(size_TableBox-1)]
        
        for box in TableBox:            
            
            TableofMedals =  box.xpath("./td")

            if year == "1900": ## 1900 has a different table structure              
                if len(TableofMedals)==6:
                    Data['Country_Name'] = box.xpath("./td[2]/a/text()").get()
                    Data['Country_Code'] = box.xpath("./td[2]/span/text()").get()
                    Data['Gold'] = box.xpath("./td[3]/text()").get()
                    Data['Silver'] = box.xpath("./td[4]/text()").get()
                    Data['Bronze'] = box.xpath("./td[5]/text()").get()

                else: ## This will trigger when two countries are tied in the same spot, so the element count for td is different.
                    Data['Country_Name'] = box.xpath("./td[1]/a/text()").get()
                    Data['Country_Code'] = box.xpath("./td[1]/span/text()").get()
                    Data['Gold'] = box.xpath("./td[2]/text()").get()
                    Data['Silver'] = box.xpath("./td[3]/text()").get()
                    Data['Bronze'] = box.xpath("./td[4]/text()").get()

            else:
                if len(TableofMedals)==5:
                    Data['Country_Name'] = box.xpath("./th/a/text()").get()
                    Data['Country_Code'] = box.xpath("./th/span/text()").get()
                    Data['Gold'] = box.xpath("./td[2]/text()").get()
                    Data['Silver'] = box.xpath("./td[3]/text()").get()
                    Data['Bronze'] = box.xpath("./td[4]/text()").get()
                else: ## This will trigger when two countries are tied in the same spot, so the element count for th is different.
                    Data['Country_Name'] = box.xpath("./th/a/text()").get()
                    Data['Country_Code'] = box.xpath("./th/span/text()").get()
                    Data['Gold'] = box.xpath("./td[1]/text()").get()
                    Data['Silver'] = box.xpath("./td[2]/text()").get()
                    Data['Bronze'] = box.xpath("./td[3]/text()").get()         

            yield Data