import type { NextPage } from 'next'
import { useRouter } from 'next/router'
import { useEffect } from 'react'
import {
  useUserState,
  fallbackUserState,
  useSnackbarState,
} from '@/hooks/useGlobalState'

const SignOut: NextPage = () => {
  const router = useRouter()
  const [, setUser] = useUserState()
  const [, setSnackbar] = useSnackbarState()

  useEffect(() => {
    localStorage.removeItem('access-token')
    localStorage.removeItem('client')
    localStorage.removeItem('uid')
    setUser(fallbackUserState)
    setSnackbar({
      message: 'ログアウトしました',
      severity: 'success',
      pathname: '/',
    })
    router.push('/')
  }, [router, setUser, setSnackbar])

  return <></>
}

export default SignOut
