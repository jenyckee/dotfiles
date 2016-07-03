
import Peer from 'peerjs'

// ------------------------------------
// Constants
// ------------------------------------
export const CONNECT = 'CONNECT'
export const OPEN = 'OPEN'

// ------------------------------------
// Actions
// ------------------------------------
export function connect (c) {
  return {
    type: CONNECT,
    payload: c
  }
}

function open (id){
  return {
    type: OPEN,
    payload: id
  }
}

function error (message) {
  console.error(message)
}

export const actions = {
  connect,
  open
}

// ------------------------------------
// Action Handlers
// ------------------------------------
const ACTION_HANDLERS = {
  [CONNECT]: (state, action) => state,
  [OPEN]: (state, action) => state
}

// ------------------------------------
// Reducer
// ------------------------------------
const connection = new Peer({
  key: 'bnon5rifq5dygb9',
  debug: 3
}).on('connection', connect)
  .on('error', error)
  .on('open', open)


const initialState = { peer: connection }
export default function counterReducer (state = initialState, action) {
  const handler = ACTION_HANDLERS[action.type]

  return handler ? handler(state, action) : state
}
