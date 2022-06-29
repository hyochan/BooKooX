import * as functions from 'firebase-functions'
import * as express from 'express'
import { StatusCodes } from 'http-status-codes'

const app = express()
app.use(express.json())
app.post('/', async (req: express.Request, res: express.Response) => {
  res.send('Hello Firebase').status(StatusCodes.OK).end()
})

exports.api = functions.region('asia-northeast3').https.onRequest(app)
