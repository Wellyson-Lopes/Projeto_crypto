namespace :dev do
  desc "configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando db...") { %x(rails db:drop) }
      show_spinner("Criando DB...") { %x(rails db:create) }
      show_spinner("Migrando DB...") { %x(rails db:migrate) }
      %x(rails dev:add_coins)
      %x(rails dev:add_mining_types)
    else
      puts "Voce não está em ambiente de desenvolvimento"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando Modas...") do
      coins = [
                  {
                  description: "Bitcoin",
                  acronym: "BTC",
                  url_image: "https://w7.pngwing.com/pngs/450/133/png-transparent-bitcoin-cryptocurrency-virtual-currency-decal-blockchain-info-bitcoin-text-trademark-logo.png"
                  },
                  {
                  description: "Ethereum",
                  acronym: "ETH",
                  url_image: "https://w7.pngwing.com/pngs/368/176/png-transparent-ethereum-cryptocurrency-blockchain-bitcoin-logo-bitcoin-angle-triangle-logo-thumbnail.png"
                  },
                  {
                  description: "Dash",
                  acronym: "DASH",
                  url_image: "https://ico-wiki.com/wp-content/uploads/2018/08/dash-coin-price.png"
                  },
                  {
                  description: "Iota",
                  acronym: "IOT",
                  url_image: "https://w7.pngwing.com/pngs/800/691/png-transparent-iota-crypto-iota-logo-iota-coin-iota-symbol-iota-sign-iota-3d-icon-thumbnail.png"
                  },
                  {
                  description: "Zcash",
                  acronym: "ZEC",
                  url_image: "https://e7.pngegg.com/pngimages/965/725/png-clipart-computer-icons-zcash-cryptocurrency-selecta-orange-number-thumbnail.png"
                  }
              ]

      coins.each do |coin|
          Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
      ]

        mining_types.each do |mining_type|
          MiningType.find_or_create_by!(mining_type)
        end
      end
    end


  def show_spinner(msg_start, msg_end = "Concluido !")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
