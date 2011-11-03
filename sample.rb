require 'fusion_tables'

# Connect to service    
@ft = GData::Client::FusionTables.new      
  @ft.clientlogin("ian_norris@berkeley.edu", "norrisi154")

puts @ft.class
@table = 1943371
# 1. SQL interface
# =========================

bob = "EMPTY SET"
bob = @ft.execute "SHOW TABLES"
puts bob


   ret = @ft.execute "SELECT count() FROM #{@table}"
   puts ret
   
   sample_poop = @ft.execute "DESCRIBE #{@table}"
   puts sample_poop
   
    ret = @ft.execute "SELECT ROWID, Text FROM #{@table}"
    puts ret

# 2. ORM interface
# ========================
# Browse existing tables
@ft.show_tables
 # => [table_1, table_2] 
