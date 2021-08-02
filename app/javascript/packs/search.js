import axios from 'axios';

const axiosConfig = {
  headers: {
    accept: 'application/json',
  },
  data: {},
};

export const ORDER_BY = {
  DEFAULT: 'Default',
  NAME: 'Name',
  PRICE: 'Price',
  POPULARITY: 'Popularity'
};

const getSearchBikeHtml = (bike) => (`
  <a href="/bikes/${bike.id}" target="_blank" class="card card--search">
    <div class="image" style='background-image: url("/assets/${bike.image_name}")'>
    </div>
    <div>
      <div class="font-bold capitalize mb-1">${bike.name}</div>
      <div class="mb-2">${bike.description}</div>
      <div class="italic">$${Number(bike.price_per_day).toFixed(2)} per day</div>
    </div>
  </a>
`);

var bikeStore;
export const initBikeStore = (bikes) => {
  const stores = bikes.map(bike => {
    bike.html = getSearchBikeHtml(bike);
    return bike;
  });

  return {
    [ORDER_BY.DEFAULT]: (() => {
      return stores.map(b => b.html).join('');
    })(),
    [ORDER_BY.NAME]: (() => {
      return stores.
        sort((a, b) => (a.name > b.name) ? 1 : -1).
        map(b => b.html).
        join('');
    })(),
    [ORDER_BY.PRICE]: (() => {
      return stores.
        sort((a, b) => (parseFloat(a.price_per_day) > parseFloat(b.price_per_day)) ? 1 : -1).
        map(b => b.html).
        join('');
    })(),
    [ORDER_BY.POPULARITY]: (() => {
      return stores.
        sort((a, b) => (a.popularity < b.popularity) ? 1 : -1).
        map(b => b.html).
        join('');
    })()
  };
}

const generateSearchBikesHtml = (orderBy) => {
  return bikeStore[orderBy];
};

const currentOrderBy = () => {
  const searchOrderByEl = document.querySelector('[data-search-order-by]');
  if (!!searchOrderByEl) {
    return searchOrderByEl.value;
  }
};

export const getBikes = (availableOn) => {
  return axios
    .get(`/search?date=${availableOn}`, axiosConfig)
    .then(({ data: bikes }) => bikes)
    .catch((error) => console.log(error));
};

const initSearchForm = () => {
  const searchOrderOnDateEl = document.querySelector('[data-search-on-date]');
  const searchBikesEl = document.querySelector('[data-search-bikes]');

  if (!!searchOrderOnDateEl) {
    searchOrderOnDateEl.addEventListener('change', (event) => {
      getBikes(event.target.value)
      .then((bikes) => {
        bikeStore = initBikeStore(bikes);
        searchBikesEl.innerHTML = generateSearchBikesHtml(currentOrderBy());
      });
    });
  }
};

const onloadSearch = () => {
  const searchBikesEl = document.querySelector('[data-search-bikes]');
  if (!!searchBikesEl) {
    getBikes()
      .then((bikes) => {
        bikeStore = initBikeStore(bikes);
        searchBikesEl.innerHTML = generateSearchBikesHtml(ORDER_BY.DEFAULT);
      });

    const searchOrderByEl = document.querySelector('[data-search-order-by]');
    if (!!searchOrderByEl) {
      searchOrderByEl.addEventListener('change', (e) => {
        searchBikesEl.innerHTML = generateSearchBikesHtml(e.target.value);
      });
    }
  }
  initSearchForm();
};

// Prevent overwriting on window.onload function by appending to the load event
if (window.attachEvent) { // IE
  window.attachEvent('onload', onloadSearch);
} else if (window.addEventListener) {
  window.addEventListener('load', onloadSearch, false);
} else {
  document.addEventListener('load', onloadSearch, false);
}
