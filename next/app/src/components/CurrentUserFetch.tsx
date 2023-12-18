import axios, { AxiosResponse, AxiosError } from 'axios'
import { useEffect } from 'react'
import { useUserState } from '@/hooks/useGlobalState'

const CurrentUserFetch = () => {
  const [user, setUser] = useUserState()

  useEffect(() => {
    if (user.isFetched) return

    if (
      !localStorage.getItem('access-token') ||
      !localStorage.getItem('client') ||
      !localStorage.getItem('uid')
    ) {
      setUser({ ...user, isFetched: true })
      return
    }

    const url = process.env.NEXT_PUBLIC_API_BASE_URL + '/current/user'
    const headers = {
      'Content-Type': 'application/json',
      'access-token': localStorage.getItem('access-token'),
      ' client': localStorage.getItem('client'),
      uid: localStorage.getItem('uid'),
    }

    axios({ method: 'GET', url: url, headers: headers })
      .then((res: AxiosResponse) => {
        setUser({
          ...user,
          ...res.data,
          isSignedIn: true,
          isFetched: true,
        })
      })
      .catch((error: AxiosError) => {
        console.log(error.message)
        setUser({
          ...user,
          isFetched: true,
        })
      })
    return () => {}
  }, [user, setUser])

  return <></>
}

export default CurrentUserFetch
