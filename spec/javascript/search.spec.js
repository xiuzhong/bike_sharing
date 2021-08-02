import axios from 'axios';
import { getBikes, generateSearchBikesHtml, ORDER_BY } from "../../app/javascript/packs/search.js";

jest.mock('axios');

describe('getBikes()', () => {
  it('gets bikes', async () => {
    axios.get.mockResolvedValue({ data: 'some_bikes' });
    const response = await getBikes();
    expect(response).toEqual('some_bikes');
  });
});

describe('generateSearchBikesHtml()', () => {
  it('generates empty search bikes HTML string', async () => {
    const response = generateSearchBikesHtml([], ORDER_BY.DEFAULT);
    expect(response).toEqual('');
  });

  it('generates search bikes HTML string', async () => {
    const bikes = [{
      description: 'some_description',
      id: 123,
      image_name: 'some_image.js',
      name: 'some_bike',
      price_per_day: '2.2',
    }];
    const response = generateSearchBikesHtml(bikes, ORDER_BY.DEFAULT);

    expect(response).toMatch(/(\/bikes\/123)/i);
    expect(response).toMatch(/(\/assets\/some_image.js)/i);
    expect(response).toMatch(/(\$2.20 per day)/i);
  });
});
