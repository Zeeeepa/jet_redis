source search/setup.sh &
echo "Setup search"

source scraped_urls/setup.sh &
echo "Setup scraped_urls"

source ollama_models/setup.sh &
echo "Setup ollama_models"

source local_search/setup.sh &
echo "Setup local_search"
