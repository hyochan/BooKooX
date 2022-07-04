import * as admin from 'firebase-admin'
import 'dotenv/config'
import { existsSync } from 'fs'
import { resolve } from 'path'

const init = async () => {
  const keyFilePath = resolve(__dirname, '../key.json')

  if (existsSync(keyFilePath)) {
    /* eslint-disable */
    // @ts-ignore
    const serviceAccount = await import(keyFilePath)
    admin.initializeApp({
      // @ts-ignore
      credential: admin.credential.cert(serviceAccount),
      databaseURL: process.env.DATABASE_URL
    })
  }

  // eslint-disable-next-line no-extra-boolean-cast
  if (shouldUseEmulator()) {
    admin.firestore().settings({ host: 'localhost:8080', ssl: false })
  }

  return admin
}

const shouldUseEmulator = (): boolean => {
  const envShouldUseEmulator = process.env.SHOULD_USE_EMULATOR?.toLowerCase()

  if (envShouldUseEmulator === 'true') {
    return true
  }

  return false
}

export default init
