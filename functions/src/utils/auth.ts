import * as admin from 'firebase-admin'
import 'dotenv/config'
import { existsSync } from 'fs'

const init = async () => {
  const keyFilePath = '../../key.json'

  if (existsSync(keyFilePath)) {
    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
    // @ts-ignore
    // eslint-disable-next-line import/no-unresolved
    const serviceAccount = await import('../key.json')
    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount),
      databaseURL: process.env.DATABASE_URL
    })
  }

  // eslint-disable-next-line no-extra-boolean-cast
  if (Boolean(process.env.SHOULD_USE_EMULATOR ?? false)) {
    admin.firestore().settings({ host: 'localhost:8080', ssl: false })
  }

  return admin
}

export default init
