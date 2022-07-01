init:
	cargo install leo-lang
	npm install --prefix fron

nix_shell:
	nix-shell

build:
	@echo "👷 * Aleo Roulette building process started *"
	@echo "========================================="
	@echo "🔨 1/1 Building the Frontend..."
	npm install --prefix front --silent 
	npm run re:build --prefix front
	@echo "==================================================="
	@echo "✅ Aleo Roulette building process finished sucessfully!"

run_front:
	npm run re:build --prefix front
	PORT=4000 npm start --prefix front

