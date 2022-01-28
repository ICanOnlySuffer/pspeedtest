require_relative '../version'

puts "pspeedtest v#{PSpeedTest::VERSION} - Piero Estéfano Rojas Effio"
puts '* https://github.com/ICanOnlySuffer/pspeedtest'
puts case ENV['LANG']
when /es/ then 'Bajo licencia MIT'
when /pt/ then 'Sob licença MIT'
else 'Under MIT Licence'
end

exit

