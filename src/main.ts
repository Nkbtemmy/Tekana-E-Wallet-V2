import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const port = process.env.PORT || 3001;
  console.log("------------ ", port)
  const app = await NestFactory.create(AppModule);
  app.enableCors();
  const config = new DocumentBuilder()
    .setTitle('Tekana E-Wallet')
    .setDescription('The Tekana E-Wallet API descriptions')
    .setVersion('1.0')
    .addSecurity('Bearer', {
      type: 'http',
      scheme: 'Bearer',
    })
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api-docs', app, document)
  app.useGlobalPipes(new ValidationPipe({ whitelist: true}));
  await app.listen(port);
}
bootstrap();
