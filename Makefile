init:
	cargo install leo-lang
	git submodule init aleo
	git submodule update
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
	cd api && PORT=5000 mix phx.server

update_aleo:
	cd aleo && git pull origin main
	cd aleo && cargo build --release
