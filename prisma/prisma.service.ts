import { INestApplication, Injectable, OnModuleInit } from "@nestjs/common";
import { PrismaClient } from "@prisma/client";

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {

    async onModuleInit() {
        try {
            await this.$connect();
            console.log("Database connected!");
        } catch (error:any) {
            console.error("Error connecting to the database:", error.message);
        }
    }

    async enableShutdownHooks(app: INestApplication) {
        const shutdownHandler = async () => {
            await this.$disconnect();
            await app.close();
        };

        process.on('beforeExit', shutdownHandler);
        process.on('SIGINT', shutdownHandler);
        process.on('SIGTERM', shutdownHandler);
    }
}
