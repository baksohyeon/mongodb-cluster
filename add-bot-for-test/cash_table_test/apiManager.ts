export interface ISettingConfig {
  GameTitle: string;
  Blind: IBlindData[];
  BettingTime: number;
  MaxPlayerCount: number;
  BettingRule: string;
  MinBuyInAmount: number;
  MaxBuyInAmount: number;
  BuytheButton: boolean;
  AnteMode: string;
  Password: string;
  TimebankBonusAmount: number;
  IsTimebankEnabled: boolean;
  TimebankBeginningAmount: number; // ms
  TimebankBonusInterval?: number;
  TimebankMaxAmount?: number;
  ShowdownTime: number;
}

export interface IBlindData {
  Index: number;
  Lv: number;
  Small: number;
  Big: number;
  PB: number;
  Ante: number;
  Time: number;
}

export class CashTableTest {
  private serverUrl: string = "http://localhost:8080/games/create";

  public async createTable(gameId: string, count: number) {
    for (let i = 0; i < count; i++) {
      const uid = this.generateRandomString(32);
      const nick = `BOT_${this.generateRandomString(8)}`;

      const data = {
        gameId: gameId,
        uid: uid,
        nick: nick,
        password: "",
      };

      try {
        const response = await fetch(this.serverUrl, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(data),
        });

        if (response.ok) {
          const result = await response.json();
          console.log(result);
        } else {
          console.error("Error creating table:", response.statusText);
        }
      } catch (error) {
        console.error("Network error:", error);
      }
    }
  }

  private generateRandomString(length: number): string {
    const chars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    let result = "";
    for (let i = 0; i < length; i++) {
      result += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return result;
  }
}
