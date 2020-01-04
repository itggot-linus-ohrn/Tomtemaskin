require 'sqlite3'
#   Databashanterare
#   Lägger till alla fetches och matcher med odds databasen
#   
class Gumman

    def self.connect
        @db = SQLite3::Database.new('db/data.db')
    end

    def self.add_fetch_db(link, deltatime)
        @db.execute('INSERT INTO fetches (link, response) VALUES (?,?)', link.to_s, deltatime.to_s)
    end


    # def self.add_odds_db(match,odds)
    #     team1 = ""
    #     team2 = ""
    #     odds[0].each do |t1o|
    #         team1 += "#{t1o.to_s}, "
    #     end
    #     odds[1].each do |t2o|
    #         team2 += "#{t2o.to_s}, "
    #     end
        
    #     @db.execute('INSERT INTO odds (match, team1, team2) VALUES (?,?,?)', match.to_s, team1, team2)
    # end

    def self.add_arbitrage_odds_db(match, arbitrage_odds)
        team1 = ""
        team2 = ""
        arbitrage_odds.each do |opp|
            team1 += "#{arbitrage_odds[opp][0][0].to_s}, "
            team2 += "#{arbitrage_odds[opp][0][1].to_s}, "
            market_margin += "#{arbitrage_odds[opp][1]}"
        end
        
        @db.execute('INSERT INTO odds (match, team1, team2, market_margin) VALUES (?,?,?)', match.to_s, team1, team2, market_margin)
    end

    def self.db_setup()

        db_temp = SQLite3::Database.new('db/data.db')

        db_temp.execute('DROP TABLE IF EXISTS fetches;')

        db_temp.execute('DROP TABLE IF EXISTS odds;')

        db_temp.execute('CREATE TABLE "fetches" (
            "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            "link"	TEXT NOT NULL,
            "response" TEXT NOT NULL
        );')

        db_temp.execute('CREATE TABLE "odds" (
            "match"	TEXT NOT NULL,
            "team1"	TEXT NOT NULL,
            "team2"	TEXT NOT NULL,
            "arbitrage" INT NOT NULL,
            "arbitrage_odds" TEXT,
            "time" TEXT NOT NULL
        );')
    
    end


end