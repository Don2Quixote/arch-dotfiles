const VK_API = require('vk_api_tool');
const fetch = require('node-fetch');

const get = async (url, data) => {
    url += '?';
    for (let key in data) {
        url += `${key}=${data[key]}&`;
    }
    let res = await fetch(url);
    return await res.json();
}

const TOKEN = 'f44l151fea8ff2f14a8ca0e4f0e359748ba7eb58ffb3836db4ea459fc44e0855bdf6ab091e19a1c6002511';
const api = new VK_API(TOKEN, '5.122', 'ru');

const getServer = async api => {
    let request = await api.use('messages.getLongPollServer', {
        lp: 3
    });
    return request;
}

const main = async () => {
    let {server, ts, key} = await getServer(api);
    server = 'https://' + server;
    while (true) {
        let res = await get(server, {
            act: 'a_check',
            ts: ts,
            key: key,
            wait: 25,
            version: 3
        });
        ts = res.ts;
        console.log(res.updates);
    }
}

main()

