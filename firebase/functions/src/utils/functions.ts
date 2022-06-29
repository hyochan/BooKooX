// eslint-disable-next-line import/no-unresolved
import { getFirestore } from 'firebase-admin/firestore'

const insertMultipleDoc = <T>(data: Array<T>) => {
  const db = getFirestore()
  const batch = db.batch()

  data.forEach((single) => {
    const userDoc = db.collection('users').doc()
    batch.set(userDoc, single)
  })

  batch.commit()
}

export { insertMultipleDoc }
