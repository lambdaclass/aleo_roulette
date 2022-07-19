PORT_API = 5000
PORT_FRONT = 4000

init:
	cargo install leo-lang
	git submodule init aleo
	git submodule update --remote --merge
	cd aleo && git pull origin main
	cd aleo && cargo build --release
	mix local.hex && mix archive.install hex phx_new
	cd api && mix deps.get && mix deps.compile
	npm install --prefix front --silent
  
nix_shell:
	nix-shell

build:
	@echo "👷 * Aleo Roulette building process started *"
	@echo "========================================="
	@echo "🔨 1/2 Building the Frontend..."
	npm install --prefix front --silent 
	npm run re:build --prefix front
	@echo "🔨 2/2 Building the API..."
	cd api && mix deps.get && mix deps.compile && mix compile
	@echo "==================================================="
	@echo "✅ Aleo Roulette building process finished sucessfully!"

run_front:
	npm run re:build --prefix front
	PORT=4000 npm start --prefix front

run_api:
	cd api && PORT=${PORT_API} mix phx.server

update_aleo:
	git submodule update --remote --merge
	cd aleo && cargo build --release

run_winning_bet_aleo:
	cd circuits/bets_aleo && aleo run bets "{ owner: aleo1r7rxeeu82vumna997t62y7yjrdc9te2zv0xqnyxyg6zmn5jjhqpsx89h2h.private, gates: 2u64.private }" "{ owner: aleo1r7rxeeu82vumna997t62y7yjrdc9te2zv0xqnyxyg6zmn4jjhqpsx89h2h.private, gates: 1000u64.private }" 2u8 2u8 2u64

run_losing_bet_aleo:
	cd circuits/bets_aleo && aleo run bets "{ owner: aleo1r7rxeeu82vumna997t62y7yjrdc9te2zv0xqnyxyg6zmn5jjhqpsx89h2h.private, gates: 2u64.private }" "{ owner: aleo1r7rxeeu82vumna997t62y7yjrdc9te2zv0xqnyxyg6zmn5jjhqpsx89h2h.private, gates: 1000u64.private }" 2u8 1u8 2u64
