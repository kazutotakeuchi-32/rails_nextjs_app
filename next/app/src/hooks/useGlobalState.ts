import useSWR from 'swr'

type userStateType = {
  id: number
  name: string
  email: string
  isSignedIn: boolean
  isFetched: boolean
}

export const fallbackUserState: userStateType = {
  id: 0,
  name: '',
  email: '',
  isSignedIn: false,
  isFetched: false,
}

export const useUserState = () => {
  const { data: state, mutate: setState } = useSWR('user', null, {
    fallbackData: fallbackUserState,
  })
  return [state, setState] as [userStateType, (value: userStateType) => void]
}

export const fallbackSnackbarData: snackbarStateType = {
  message: null,
  severity: null,
  pathname: null,
}

type snackbarStateType = {
  message: string | null
  severity: 'success' | 'error' | null
  pathname: string | null
}

export const useSnackbarState = () => {
  const { data: state, mutate: setState } = useSWR('snackbar', null, {
    fallbackData: fallbackSnackbarData,
  })
  return [state, setState] as [
    snackbarStateType,
    (value: snackbarStateType) => void,
  ]
}
