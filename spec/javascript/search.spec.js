import axios from 'axios';
import { getBikes, initBikeStore, ORDER_BY } from "../../app/javascript/packs/search.js";

jest.mock('axios');

describe('getBikes()', () => {
  it('gets bikes', async () => {
    axios.get.mockResolvedValue({ data: 'some_bikes' });
    const response = await getBikes();
    expect(response).toEqual('some_bikes');
  });
});

describe('initBikeStore()', () => {
  it('generates empty search bikes HTML string', async () => {
    const response = initBikeStore([])[ORDER_BY.DEFAULT];
    expect(response).toEqual('');
  });

  it('generates search bikes HTML string', async () => {
    const bikes = [{
      description: 'some_description',
      id: 123,
      image_name: 'some_image.js',
      name: 'some_bike',
      price_per_day: '2.2',
      popularity: 1
    }];
    const response = initBikeStore(bikes)[ORDER_BY.DEFAULT];

    expect(response).toMatch(/(\/bikes\/123)/i);
    expect(response).toMatch(/(\/assets\/some_image.js)/i);
    expect(response).toMatch(/(\$2.20 per day)/i);
  });

  it('generates search bikes HTML string as per sort_by', async () => {
    const bikes = [
      {
        name: 'alfha',
        description: 'some_description',
        id: 1,
        image_name: 'some_image.js',
        price_per_day: '17.2',
        popularity: 0
      },
      {
        name: 'delta',
        description: 'some_description',
        id: 2,
        image_name: 'some_image.js',
        price_per_day: '2.3',
        popularity: 1
      },
      {
        name: 'beta',
        description: 'some_description',
        id: 3,
        image_name: 'some_image.js',
        price_per_day: '5.3',
        popularity: 4
      }
    ];
    const regex = /(alfha|beta|delta)/g;
    const expected = {
      [ORDER_BY.DEFAULT]: ['alfha', 'delta', 'beta'],
      [ORDER_BY.NAME]: ['alfha', 'beta', 'delta'],
      [ORDER_BY.PRICE]: ['delta', 'beta', 'alfha'],
      [ORDER_BY.POPULARITY]: ['beta', 'delta', 'alfha'],
    }
    for (const sortBy in expected) {
      const response = initBikeStore(bikes)[sortBy];
      expect(response.match(regex)).toEqual(expected[sortBy])
    }
  });
});
