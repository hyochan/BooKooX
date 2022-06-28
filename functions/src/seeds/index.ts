import { faker } from '@faker-js/faker'
import init from '../utils/auth'
import 'dotenv/config'

import insertUsers from './user'

const configSeed = async () => {
  faker.setLocale(process.env.FAKER_LOCALE ?? 'en')
  await init()
}

const main = async () => {
  await configSeed()
  insertUsers(10)
}

main()
