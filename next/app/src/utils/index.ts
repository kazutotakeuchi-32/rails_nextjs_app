import axios, { AxiosResponse, AxiosError } from 'axios'

export const fetcher = (url: string) =>
  axios
    .get(url, {
      headers: {
        'Content-Type': 'application/json',
        'access-token': localStorage.getItem('access-token'),
        uid: localStorage.getItem('uid'),
        client: localStorage.getItem('client'),
      },
    })
    .then((res: AxiosResponse) => res.data)
    .catch((err: AxiosError) => {
      throw err
    })
