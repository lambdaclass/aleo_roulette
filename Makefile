PORT_API?=3000
PORT_FRONT?=4000
REACT_APP_API_HOST?=http://localhost:3000

init:
	git submodule init aleo
	git submodule update
	cd aleo && cargo build --release
	mix local.hex --force
	mix local.rebar --force
	mix archive.install --force hex phx_new
  
nix:
	nix-shell

build:
	@echo "👷 * Aleo Roulette building process started *"
	@echo "======================================================"
	@echo "🔨 1/3 Building the Aleo Circuits..."
	cd circuits/bets && aleo clean && aleo build  && aleo run psd_hash 3u32
	@echo "🔨 2/3 Building the API..."
	cd api && mix deps.get && mix deps.compile && mix compile
	@echo "🔨 3/3 Building the Frontend..."
	npm install --prefix front
	npm run re:build --prefix front
	@echo "======================================================"
	@echo "✅ Aleo Roulette building process finished sucessfully!"

run_front:
	npm run re:build --prefix front
	PORT=${PORT_FRONT} REACT_APP_API_HOST=${REACT_APP_API_HOST} npm start --prefix front

run_api:
	cd api && PORT=${PORT_API} mix phx.server 

update_aleo:
	git submodule update --remote --merge
	cd aleo && cargo build --release

build_circuits:
	cd circuits/bets && aleo clean && aleo build
