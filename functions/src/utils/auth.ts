import * as admin from 'firebase-admin'
import 'dotenv/config'

const init = async () => {
  const serviceAccount = await import('../../key.json')

  console.log()
  admin.initializeApp({
    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
    // @ts-ignore
    credential: admin.credential.cert(serviceAccount),
    databaseURL: process.env.DATABASE_URL
  })

  // eslint-disable-next-line no-extra-boolean-cast
  if (Boolean(process.env.SHOULD_USE_EMULATOR)) {
    admin.firestore().settings({ host: 'localhost:8080', ssl: false })
  }

  return admin
}

export default init
