import { useRouter } from 'next/router'
import { useEffect } from 'react'
import { useUserState, useSnackbarState } from '@/hooks/useGlobalState'

export const useRequireSignedIn = () => {
  const router = useRouter()
  const [user] = useUserState()
  const [, setSnackbarState] = useSnackbarState()

  useEffect(() => {
    if (!user.isSignedIn && user.isFetched) {
      router.push('/sign_in')
      setSnackbarState({
        message: 'サインインしてください',
        severity: 'error',
        pathname: '/sign_in',
      })
    }
  }, [user, router, setSnackbarState])
}
