class CsvReader
  require 'csv'

  def self.read_file
    texts = []
    user = []
    employee = []
    csv =  CSV.parse(IO.read('1.csv', {:encoding => 'ISO-8859-14'}))
    csv.each do |row|
      row = row.compact
      row.empty? ? '' : texts << row
    end
    texts = texts.flatten.select { |x| x.include?(':') }
    texts = texts.select {|x| !x.include?('ha abandonado la sesion')}
    texts.delete_if { |x| x.length < 6 }

    texts.map!{ |x| x.include?('.int') ? employee << x : user << x }
    employee = employee.map!{|x| x.split(":").last[1..-1]}
    user = user.map!{|x| x.split(":").last[1..-1]}
    user.delete_if { |x| x.length < 6 }
    employee.delete_if { |x| x.length < 6 }

    File.open("employee.txt", "w+") do |f|
      employee.each { |e| f.puts("\"#{e}\"") }
    end

    File.open("user.txt", "w+") do |f|
      user.each { |u| f.puts("\"#{u}\"") }
    end

  end

end


CsvReader.read_file