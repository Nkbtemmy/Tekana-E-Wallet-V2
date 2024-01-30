import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { PrismaModule } from 'prisma/prisma.module';
import { AccountService } from './account/account.service';
import { UserModule } from './user/user.module';
import { AccountModule } from './account/account.module';

@Module({
  imports: [ConfigModule.forRoot(), PrismaModule, UserModule, AccountModule],
  controllers: [],
  providers: [AccountService],
})
export class AppModule {}
